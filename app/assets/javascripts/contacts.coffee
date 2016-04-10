$(document).on 'click', '.add-new-phone', (e)->
  e.preventDefault()
  # Generar un numero aleatorio que servirá para el generador
  # de nuevos numeros de telefono
  random_id = Math.floor(Math.random() * (9999999 - 0))
  $("""
    <div class="field">
      <label for="contact_phones_attributes_#{random_id}_number">
        Numero
      </label>
      <input type="text" name="contact[phones_attributes][#{random_id}][number]" id="contact_phones_attributes_#{random_id}_number">
    </div>""").appendTo('#phones-form')
