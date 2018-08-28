function toggleEditFormHiddenClases(editButton) {
  const dataRow = editButton.parentNode.parentNode;
  const form = dataRow.previousElementSibling;
  form.classList.toggle("hidden");
  dataRow.classList.toggle("hidden");
}

function toggleNewFormHiddenClases(addButton) {
  const form = document.querySelector("#new_share");
  form.classList.toggle("hidden");
  addButton.classList.toggle("hidden");
}

function closeForm(closeBtn) {
  const form = closeBtn.parentNode.parentNode;
  const dataRow = form.nextElementSibling;
  const addButton = document.querySelector(".show-new-share-form");
  form.classList.toggle("hidden");

  if (dataRow){
    dataRow.classList.toggle("hidden");
  }

  if(addButton.classList.contains("hidden")) {
    addButton.classList.remove("hidden")
  }
}

function addClickListeners(elements, callback) {
  for (let i = 0; i < elements.length; i++) {
    elements[i].addEventListener("click", (event) => {
      event.preventDefault();
      callback(event.currentTarget);
    })
  }
}

function init() {
  const editButtons = document.querySelectorAll(".edit-share-info");
  const showFormButtons = document.querySelectorAll(".show-new-share-form");
  const closeFormBtns = document.querySelectorAll(".close-form-btn");
  if (editButtons) {
    addClickListeners(editButtons, toggleEditFormHiddenClases);
  }

  if (showFormButtons){
    addClickListeners(showFormButtons, toggleNewFormHiddenClases);
  }

  if (closeFormBtns) {
    addClickListeners(closeFormBtns, closeForm);
  }
}

document.addEventListener("DOMContentLoaded", () => {
  init();
})

