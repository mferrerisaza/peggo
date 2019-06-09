import SlimSelect from 'slim-select'
import "slim-select/src/slim-select/slimselect.scss";

document.addEventListener("DOMContentLoaded", () => {
  const $contactSelect = document.getElementById("expense_contact_id");
  if($contactSelect) {
    new SlimSelect({
      select: '#expense_contact_id'
    })
  }
})


