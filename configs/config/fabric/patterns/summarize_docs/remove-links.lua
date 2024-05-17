function Link(el)
  -- Return the content of the link without the link itself
  return el.content
end

function Image(el)
  -- Return the content of the link without the link itself
  return el.content
end

-- Return the document unchanged if the element is not a Link
return {
  {
    Link = Link,
    Image = Image

  }
}
