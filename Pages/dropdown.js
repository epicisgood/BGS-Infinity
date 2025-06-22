 document.addEventListener("DOMContentLoaded", () => {
    window.chrome.webview.addEventListener('message', applySettings);
  })

document.querySelectorAll('.custom-dropdown').forEach(dropdown => {
  const selected = dropdown.querySelector('.custom-dropdown-selected');
  const options = dropdown.querySelector('.custom-dropdown-options');
  const hiddenInput = document.getElementById('hiddenSelector');

  selected.addEventListener('click', () => {
    options.style.display = options.style.display === 'block' ? 'none' : 'block';
  });

  options.querySelectorAll('[data-value]').forEach(option => {
    option.addEventListener('click', () => {
      const value = option.getAttribute('data-value');
      selected.textContent = option.textContent;
      hiddenInput.value = value;
      options.style.display = 'none';
    });
  });

  document.addEventListener('click', e => {
    if (!dropdown.contains(e.target)) {
      options.style.display = 'none';
    }
  });
});


document.querySelectorAll('.custom-dropdown-options div[data-value]').forEach(option => {
  option.addEventListener('click', function () {
    const selected = this.closest('.custom-dropdown').querySelector('.custom-dropdown-selected');
    const selectedKey = selected.getAttribute('data-value');

    const hiddenInput = document.querySelector(`input[type="hidden"][data-value="${selectedKey}"]`);

    const value = this.getAttribute('data-value');
    const text = this.textContent.trim();

    if (hiddenInput) {
      hiddenInput.value = value;
    }

    const img = this.querySelector('img');
    if (img) {
      const newImg = img.cloneNode(true);
      selected.innerHTML = ''; 
      selected.appendChild(newImg);
      selected.append(' ' + text);
    } else {
      selected.textContent = text;
    }
  });
});






function selectDropdownValueByData(value) {
  const option = document.querySelector(`.custom-dropdown-options div[data-value="${value}"]`);
  if (!option) return;

  const dropdown = option.closest('.custom-dropdown');
  const selected = dropdown.querySelector('.custom-dropdown-selected');
  const hiddenInput = document.getElementById('hiddenSelector');
  const text = option.textContent.trim();

  hiddenInput.value = value;

  const img = option.querySelector('img');
  if (img) {
    const newImg = img.cloneNode(true);
    selected.innerHTML = '';
    selected.appendChild(newImg);
    selected.append(' ' + text);
  } else {
    selected.textContent = text;
  }

  dropdown.querySelector('.custom-dropdown-options').style.display = 'none';
}
