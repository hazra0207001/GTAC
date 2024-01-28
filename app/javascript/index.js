// app/assets/javascripts/search.js

document.addEventListener("DOMContentLoaded", function () {
  const searchOptionSelect = document.getElementById("search_option");
  const nameInput = document.getElementById("name");
  const purchaseDateStartInput = document.getElementById("purchase_date_start");
  const purchaseDateEndInput = document.getElementById("purchase_date_end");
  const typeInput = document.getElementById("type");

  function toggleInputs(disableName, disableDate, disableType) {
    nameInput.disabled = disableName;
    purchaseDateStartInput.disabled = disableDate;
    purchaseDateEndInput.disabled = disableDate;
    typeInput.disabled = disableType;
  }

  // Initial state
  toggleInputs(true, true, true);

  searchOptionSelect.addEventListener("change", function () {
    const selectedOption = searchOptionSelect.value;

    switch (selectedOption) {
      case "Search by name or category":
        toggleInputs(false, true, true);
        break;
      case "Search by purchase date range":
        toggleInputs(true, false, true);
        break;
      case "Search by type":
        toggleInputs(true, true, false);
        break;
      default:
        toggleInputs(true, true, true);
    }
  });
});
