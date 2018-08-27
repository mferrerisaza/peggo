function toggleEditFormHiddenClases(editButton) {
  const dataRow = editButton.parentNode.parentNode;
  const form = dataRow.previousElementSibling;
  form.classList.toggle("hidden");
  dataRow.classList.toggle("hidden");
}

function toggleNewFormHiddenClases() {
  const form = document.querySelector(".new-share-form")
  const addButton = document.querySelector(".show-edit-share-form.no-form-btn")
  form.classList.toggle("hidden");
  addButton.classList.toggle("hidden");
}

function addEditButtonsListener(editButtons) {
  for (let i = 0; i < editButtons.length; i++) {
    editButtons[i].addEventListener("click", (event) => {
      event.preventDefault();
      toggleEditFormHiddenClases(event.currentTarget);
    })
  }
}

function addShowFormBtnsListener(showFormButtons) {
  for (let i = 0; i < showFormButtons.length; i++) {
    showFormButtons[i].addEventListener("click", (event) => {
      event.preventDefault();
      toggleNewFormHiddenClases();
    })
  }
}

document.addEventListener("DOMContentLoaded", () => {
  const editButtons = document.querySelectorAll(".edit-share-info");
  const showFormButtons = document.querySelectorAll(".show-edit-share-form");

  if (editButtons) {
    addEditButtonsListener(editButtons);
  }

  if (showFormButtons){
    addShowFormBtnsListener(showFormButtons);
  }
})
