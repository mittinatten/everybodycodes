defmodule Quest15.Graph do
  alias __MODULE__
  defstruct edges: [], vertices: []

  def init(map = %Quest15.Map{}) do
    add_vertex(%Graph{}, map.door)
    |> add_neighbors(map.door, map)
  end

  defp add_neighbors(graph = %Graph{}, vertex, map = %Quest15.Map{}) do
    neighbours =
      Quest15.Map.get_neighbours(map, vertex)

    newNeighbors = Enum.filter(neighbours, &(!has_vertex?(graph, &1)))

    graph = Enum.reduce(neighbours, graph, &add_vertex(&2, &1))
    graph = Enum.reduce(neighbours, graph, &add_edge(&2, {vertex, &1}))
    graph = Enum.reduce(neighbours, graph, &add_edge(&2, {&1, vertex}))
    newNeighbors |> Enum.reduce(graph, &add_neighbors(&2, &1, map))
  end

  def add_edge(graph = %Graph{}, edge) do
    if has_edge?(graph, edge),
      do: graph,
      else: %Graph{graph | edges: [edge | graph.edges]}
  end

  def add_vertex(graph = %Graph{}, vertex) do
    if has_vertex?(graph, vertex),
      do: graph,
      else: %Graph{graph | vertices: [vertex | graph.vertices]}
  end

  def has_vertex?(graph = %Graph{}, vertex) do
    Enum.find(graph.vertices, &(&1 == vertex))
  end

  def has_edge?(graph = %Graph{}, edge) do
    Enum.member?(graph.edges, edge)
  end

  def get_edges_from(graph = %Graph{}, vertex) do
    Enum.filter(graph.edges, fn {v1, _} -> v1 == vertex end)
  end

  def get_neighbors(graph = %Graph{}, vertex) do
    graph |> get_edges_from(vertex) |> Enum.map(fn {_, v} -> v end)
  end

  # dijkstra, notation from https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm
  def shortest_path(graph = %Graph{}, source, target) do
    if !has_vertex?(graph, source) || !has_vertex?(graph, target) do
      nil
    else
      distances =
        graph.vertices
        # atoms are larger than all numbers, i.e. :infinity is "large" 🤷‍♂️
        |> Enum.reduce(%{}, fn vertex, map -> Map.put(map, vertex, :infinity) end)
        |> Map.put(source, 0)

      prev =
        graph.vertices
        |> Enum.reduce(%{}, fn vertex, map -> Map.put(map, vertex, nil) end)

      q = graph.vertices
      iterate(graph, target, distances, prev, q)
    end
  end

  defp iterate(_graph, _target, _distances, _prev, []), do: :infinity

  # we're not using prev at the moment'
  defp iterate(graph = %Graph{}, target, distances, prev, q) do
    u = Enum.min_by(q, &distances[&1])

    if target == u do
      distances[target]
    else
      {distances, prev} =
        get_neighbors(graph, u)
        |> Enum.filter(&Enum.member?(q, &1))
        |> Enum.reduce({distances, prev}, fn v, {distances, prev} ->
          alt = distances[u] + 1

          if alt < distances[v] do
            {Map.put(distances, v, alt), Map.put(prev, v, u)}
          else
            {distances, prev}
          end
        end)

      iterate(graph, target, distances, prev, List.delete(q, u))
    end
  end
end
