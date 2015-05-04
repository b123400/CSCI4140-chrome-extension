storage <- chrome.storage.local.get null

debugger

findAndFill = (id, value='')->
  document.getElementById storage[id] .value = storage[value]

try
  findAndFill 'Login Name Field ID' 'Login Name Field Value'
  findAndFill 'Password Field ID' 'Password Field Value'

  autoSubmitForm = ->
    if storage['Auto Submit']
      if document.getElementsByClassName('alert alert-danger')?.length
        alert 'Auto login failed'
        return
      form = document.getElementById storage['Form ID']
      form.submit!

  try
    image = new Image()
    image.src = document.getElementById storage['Captcha Picture ID'] .src
    <- image.addEventListener 'load'
    canvas = document.createElement 'canvas'
    canvas.height = image.height
    canvas.width = image.width
    imgDraw = canvas.getContext '2d'
    imgDraw.drawImage image, 0, 0
    string = OCRAD imgDraw
    document.getElementById storage['Captcha Input Field ID'] .value = string
    autoSubmitForm!

  catch error
    autoSubmitForm!

catch error
  # wow