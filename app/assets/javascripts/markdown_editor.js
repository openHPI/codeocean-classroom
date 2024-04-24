/**
 * ToastUi editor initializer
 *
 * This script transforms form textareas created with
 * "MarkdownFormBuilder" into ToastUi markdown editors.
 *
 */

const initializeMarkdownEditors = () => {
  const editors = document.querySelectorAll(
    '[data-behavior="markdown-editor-widget"]'
  );

  editors.forEach((editor) => {
    const formInput = document.querySelector(`#${editor.dataset.id}`);
    if (!editor || !formInput) return;

    const toastEditor = new ToastUi({
      el: editor,
      initialValue: formInput.value,
      placeholder: formInput.placeholder,
      extendedAutolinks: true,
      linkAttributes: {
        target: "_blank",
      },
      previewHighlight: false,
      height: "400px",
      autofocus: false,
      usageStatistics: false,
      language: I18n.locale,
      toolbarItems: [
        ["heading", "bold", "italic"],
        ["link", "quote", "code", "codeblock"],
        ["ul", "ol"],
      ],
      initialEditType: "markdown",
      events: {
        change: () => {
          // Keep real form <textarea> in sync
          const content = toastEditor.getMarkdown();
          formInput.value = content;
        },
      },
    });

    // Prevent user from drag'n'dropping images in the editor
    toastEditor.removeHook("addImageBlobHook");

    // Delegate focus from form input to toast ui editor
    formInput.addEventListener("focus", () => {
      toastEditor.focus();
    });
  });
};

$(document).on("turbolinks:load", function () {
  initializeMarkdownEditors();
});
