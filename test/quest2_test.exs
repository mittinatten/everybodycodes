defmodule Quest2Tests do
  use ExUnit.Case

  test "parses words" do
    assert Quest2.parseWordsSpec("") == []
    assert Quest2.parseWordsSpec("WORDS: A") == ["A"]
    assert Quest2.parseWordsSpec("WORDS: A,B") == ["A", "B"]
  end

  test "counts words" do
    assert Quest2.countWords([""], []) == 0
    assert Quest2.countWords(["A"], []) == 0
    assert Quest2.countWords([""], ["A"]) == 0
    assert Quest2.countWords(["A B"], ["A", "B"]) == 2
    assert Quest2.countWords(["A B A"], ["A"]) == 2
    assert Quest2.countWords(["A B A"], ["C"]) == 0
    assert Quest2.countWords(["A B A", "C"], ["C"]) == 1
  end

  test "finds letters for word" do
    assert Quest2.findLettersForWord("", "A") == []
    assert Quest2.findLettersForWord("A", "A") == [1]
    assert Quest2.findLettersForWord("B", "A") == [0]
    assert Quest2.findLettersForWord("BA", "A") == [0, 1]
    assert Quest2.findLettersForWord("BAA", "AA") == [0, 1, 1]
    assert Quest2.findLettersForWord("BAABC AA", "AA") == [0, 1, 1, 0, 0, 0, 1, 1]
    assert Quest2.findLettersForWord("X Y Z", "AA") == [0, 0, 0, 0, 0]
  end

  test "counts letters with reverse" do
    assert Quest2.Part2.countLettersWithReverse([], []) == 0
    assert Quest2.Part2.countLettersWithReverse(["A"], []) == 0
    assert Quest2.Part2.countLettersWithReverse([], ["A"]) == 0
    assert Quest2.Part2.countLettersWithReverse(["A"], ["A"]) == 1
    assert Quest2.Part2.countLettersWithReverse(["AB"], ["AB"]) == 2
    assert Quest2.Part2.countLettersWithReverse(["ABC"], ["AB"]) == 2
    assert Quest2.Part2.countLettersWithReverse(["ABCBA"], ["AB"]) == 4
    assert Quest2.Part2.countLettersWithReverse(["QAQAQ"], ["QAQ"]) == 5
  end

  test "checks helmet for part 1" do
    assert Quest2.Part1.checkHelmet(
             "WORDS:THE,OWE,MES,ROD,HER\n\n" <>
               "AWAKEN THE POWER ADORNED WITH THE FLAMES BRIGHT IRE"
           ) == 4

    assert Quest2.Part1.checkHelmet(
             "WORDS:THE,OWE,MES,ROD,HER\n\n" <>
               "THE FLAME SHIELDED THE HEART OF THE KINGS"
           ) == 3

    assert Quest2.Part1.checkHelmet(
             "WORDS:THE,OWE,MES,ROD,HER\n\n" <>
               "POWE PO WER P OWE R"
           ) == 2

    assert Quest2.Part1.checkHelmet(
             "WORDS:THE,OWE,MES,ROD,HER\n\n" <>
               "THERE IS THE END"
           ) == 3
  end

  test "checks shield for part 2" do
    assert Quest2.Part2.checkShield("WORDS:THE,OWE,MES,ROD,HER,QAQ

    AWAKEN THE POWE ADORNED WITH THE FLAMES BRIGHT IRE") == 15

    assert Quest2.Part2.checkShield("WORDS:THE,OWE,MES,ROD,HER,QAQ

    THE FLAME SHIELDED THE HEART OF THE KINGS") == 9

    assert Quest2.Part2.checkShield("WORDS:THE,OWE,MES,ROD,HER,QAQ

    POWE PO WER P OWE R") == 6

    assert Quest2.Part2.checkShield("WORDS:THE,OWE,MES,ROD,HER,QAQ

    THERE IS THE END") == 7

    assert Quest2.Part2.checkShield("WORDS:THE,OWE,MES,ROD,HER,QAQ

    AWAKEN THE POWE ADORNED WITH THE FLAMES BRIGHT IRE
    THE FLAME SHIELDED THE HEART OF THE KINGS
    POWE PO WER P OWE R
    THERE IS THE END
    QAQAQ") == 42
  end

  test "checks armour for part 3" do
    assert Quest2.Part3.checkArmour("WORDS:AB

    ABZ
    BYD
    XAB") == 5

    assert Quest2.Part3.checkArmour("WORDS:THE,OWE,MES,ROD,RODEO

    HELWORLT
    ENIGWDXL
    TRODEOAL") == 10
  end
end
