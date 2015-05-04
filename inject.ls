storage <- chrome.storage.local.get null

debugger

allFields =
  'Captcha Picture ID'
  'Captcha Input Field ID'

findAndFill = (id, value='')->
  document.getElementById storage[id] .value = storage[value]

try
  findAndFill 'Login Name Field ID' 'Login Name Field Value'
  findAndFill 'Password Field ID' 'Password Field Value'

  if storage['Auto Submit']
    if document.getElementsByClassName('alert alert-danger')?.length
      alert 'Auto login failed'
      return
    form = document.getElementById storage['Form ID']
    form.submit!

catch error
  # wow