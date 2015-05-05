storage = null

getStorage = (cb)->
  s <- chrome.storage.local.get null
  storage := s
  cb!

findAndFill = (id, value='')-->
  document.getElementById storage[id] .value = storage[value]

fillForm = (cb)->
  <- getStorage

  try
    findAndFill 'Login Name Field ID' 'Login Name Field Value'
    findAndFill 'Password Field ID' 'Password Field Value'

    try
      image = new Image
      image.src = document.getElementById storage['Captcha Picture ID'] .src
      <- image.addEventListener 'load'
      canvas = document.createElement 'canvas'
      canvas.height = image.height
      canvas.width = image.width
      imgDraw = canvas.getContext '2d'
      imgDraw.drawImage image, 0, 0
      string = OCRAD imgDraw
      document.getElementById storage['Captcha Input Field ID'] .value = string
      cb!
    catch e
      cb!

  catch e
    #pass

isLoginOkPage = -> document.getElementsByClassName('alert alert-success')?.length > 0
isLoginFailPage = -> document.getElementsByClassName('alert alert-danger')?.length > 0

autoSubmitForm = ->
  return if not storage['Auto Submit']
  return if isLoginOkPage!
  if isLoginFailPage!
    alert 'Auto login failed'
    return
  form = document.getElementById storage['Form ID']
  form.submit!

chrome.runtime.onMessage.addListener (request, _, sendResponse)->
  if request?.command is 'fill'
    <- getStorage
    fillForm ->
      autoSubmitForm!
      sendResponse true

fillForm -> autoSubmitForm!