function map.Colors_Create()
  local colors = {}
  colors.ColorList = {}

  function colors.AddColor(text, number, hexCode)
    local color = {}
    color.text = text
    color.number = number
    color.hexCode = hexCode

    table.insert(colors.ColorList, color)
  end

  -- This function returns a color object from text
  function colors.GetColor_T(t)
    for _,v in ipairs(colors.ColorList) do
      if t == v.text then
        return v
      end
    end
  end

  function colors.GetColor_N(n)
    for _,v in ipairs(colors.ColorList) do
      if n == v.number then
        return v
      end
    end
  end

  function colors.GetColorCode(text)
    for _,v in ipairs(colors.ColorList) do
      if text == v.text then
        return v.hexCode
      end
    end
  end

  function colors.GetColoredString(normalString, colorName)
    local coloredString = "|c" .. colors.GetColorCode(colorName) .. normalString  .. "|r"
    return coloredString
  end

  colors.AddColor("red", 1, "00FF0303")
  colors.AddColor("blue", 2, "000042FF")
  colors.AddColor("teal", 3, "001CE6B9")
  colors.AddColor("purple", 4, "00540081")
  colors.AddColor("yellow", 5, "00FFFC00")
  colors.AddColor("orange", 6, "00FE8A0E")
  colors.AddColor("green", 7, "0020C000")
  colors.AddColor("pink", 8, "00E55BB0")
  colors.AddColor("gray", 9, "00959697")
  colors.AddColor("light_blue", 10, "007EBFF1")
  colors.AddColor("dark_green", 11, "00106246")
  colors.AddColor("brown", 12, "004E2A04")
  colors.AddColor("maroon", 13, "009B0000")
  colors.AddColor("navy", 14, "000000C3")
  colors.AddColor("turquoise", 15, "0000EAFF")
  colors.AddColor("violet", 16, "00BE00FE")
  colors.AddColor("wheat", 17, "00EBCD87")
  colors.AddColor("peach", 18, "00F8A48B")
  colors.AddColor("mint", 19, "00BFFF80")
  colors.AddColor("lavender", 20, "00DCB9EB")
  colors.AddColor("coal", 21, "00282828")
  colors.AddColor("snow", 22, "00EBF0FF")
  colors.AddColor("emerald", 23, "0000781E")
  colors.AddColor("peanut", 24, "00A46F33")
  colors.AddColor("some_weird_green", 25, "0022744F")
  colors.AddColor("gold", 26, "00FFD700")
  colors.AddColor("bright_blue", 27, "0019CAF6")

  return colors
end

function map.Colors_Tests(testFramework)
  testFramework.Suites.ColorsSuite = {}
  testFramework.Suites.ColorsSuite.Tests = {}
  local tsc = testFramework.Suites.ColorsSuite


  function tsc.Setup() end
  function tsc.Teardown() end

  function tsc.Tests.DummyTest()
    assert(true)
  end
end
