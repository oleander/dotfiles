function Link(el)
  return el.content
end

function Image(el)
  return el.caption
end

function Emph(el)
  return el.content
end

function Strong(el)
  return el.content
end

return {
  {
    Link = Link,
    Image = Image,
    Emph = Emph,
    Strong = Strong,
  }
}
