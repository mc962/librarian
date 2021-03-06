// form validation using https://getbootstrap.com/docs/4.0/components/forms/
window.addEventListener('load', () => {
    const forms = document.getElementsByClassName('needs-validation');

    const validation = Array.prototype.filter.call(forms, (form) => {
        form.addEventListener('submit', (event: Event) => {
            if (form.checkValidity() === false) {
                event.preventDefault();
                event.stopPropagation();
            }

            form.classList.add('was-validated');
        }, false);
    });
}, false);