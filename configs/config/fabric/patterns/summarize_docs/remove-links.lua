function Link(el)
  -- Return the content of the link without the link itself
  return el.content
end

function Image(el)
  -- Return the content of the image alt text without the image itself
  return el.caption
end

-- Return the document unchanged if the element is not a Link or Image
return {
  {
    Link = Link,
    Image = Image
  }
}
