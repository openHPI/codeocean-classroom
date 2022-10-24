ready =->
  initializeUploadedFileDeletion()
  initializeToggleEditorAttachment()
  initializeOnUpload()
  initializeExtractText()

$(document).on('turbolinks:load', ready)

initializeUploadedFileDeletion =->
  $('form').on 'click', '.remove-attachment', (event) ->
    event.preventDefault()
    $(this).parent().hide()
    $(this).parents('.attachment').find('.alternative').show()
    $(this).parents('.attachment').find('.use-attached-file').val(false)

initializeExtractText =->
  $('form').on 'click', '.extract-text', (event) ->
    $button = $(this)
    id = $button.data('file-id')
    $.ajax({
      type: 'GET',
      url: "/task_files/#{id}/extract_text_data",
      success: (response) ->
        $content = $button.parents('.toggle-divs')
        $editor = $content.find('.editor')
        setAceEditorValue($editor[0], response.text_data)
        $attachment = $content.find('.attachment')
        $attachment.find('.alternative-input').attr('disabled', true)
        $attachment.find('.use-attached-file').val(false)
        $attachment.hide()
        $edit = $content.find('.edit')
        $edit.find('hidden').attr('disabled', false)
        $edit.show()
    })



initializeToggleEditorAttachment =->
  $('form').on 'click','.toggle-input', (event) ->
    event.preventDefault()
    $content = $(this).next()
    $editor = $content.find('.edit')
    $attachment = $content.find('.attachment')

    if ($attachment.css('display') == 'none')
      $(this).text($(this).data('text-toggled'))
      $editor.find('.hidden').attr('disabled', true)
      $editor.hide()
      $attachment.find('.use-attached-file').val($attachment.find('.attachment_present').length > 0)
      $attachment.find('.alternative-input').attr('disabled', false)
      $attachment.show()
    else
      $(this).text($(this).data('text-initial'))
      $attachment.find('.alternative-input').attr('disabled', true)
      $attachment.find('.use-attached-file').val(false)
      $attachment.hide()
      $editor.find('hidden').attr('disabled', false)
      $editor.show()
    return

initializeOnUpload =->
  $('form').on 'change', '.alternative-input', (event) ->
    $(this).parents('.attachment').find('.use-attached-file').val(true)
    event.preventDefault()
    fullPath = this.value
    fullName = get_filename_from_full_path(fullPath)
    if fullPath
      $(this).parents('.file-container').find('.file-name').val(fullName)
