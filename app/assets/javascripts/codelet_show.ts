export const codeletDeleteListener = () => {
    document.addEventListener('click', (event) => {
        const target = event.target as HTMLFormElement
        const eventElId: string = target.id;
        if (eventElId === 'delete_codelet_btn') {
            event.preventDefault();
            event.stopPropagation();
            if (window.confirm('Do you want to DELETE this codelet?')) {
                const deleteItemBtn = event.target as HTMLFormElement;
                deleteItemBtn.form.submit();
            }
        }
    }, false);
};