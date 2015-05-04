storage <- chrome.storage.local.get null

allFields =
  'Form ID'
  'Login Name Field ID'
  'Login Name Field Value'
  'Password Field ID'
  'Password Field Value'
  'Captcha Picture ID'
  'Captcha Input Field ID'

makeDiv = -> document.createElement 'div'

makeField = (name, type='text')->
  div = makeDiv!
  (makeContent name, type).forEach div~appendChild
  div

makeContent = (name, type='text')->
  [
    document.createElement('span') <<<
      innerHTML : name
    ,
    document.createElement('input') <<<
      type : type
      value : storage[name] || ''
      id : name
      checked : (if type is 'checkbox' then storage[name] else '')
  ]

makeFields = ->
  allFields.map makeField

addForm = (container)->
  makeFields!.forEach container~appendChild

  container.appendChild makeField 'Auto Submit', 'checkbox'

  container.appendChild document.createElement('button') <<<
    innerHTML : 'Save'
    onclick : saveForm

  container.appendChild document.createElement('button') <<<
    innerHTML : 'Save and fill button'
    onclick : saveAndFillForm

saveForm = (cb)->
  values = {}
  allFields.forEach (f)-> values[f] = document.getElementById f .value
  values['Auto Submit'] = document.getElementById 'Auto Submit' .checked
  e <- chrome.storage.local.set values
  cb? e

saveAndFillForm = (cb)->
  saveForm cb

addForm document.body