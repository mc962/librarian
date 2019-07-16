import createDomPurify from 'dompurify';
const DOMPurify = createDomPurify(window);

class ExampleFieldsManager {
    examples_list: HTMLUListElement;

    constructor() {
        this.examples_list = document.getElementById('examples_list') as HTMLUListElement;
        
        this.insertBlankExample();
        this._addExampleListener();
    }

    static generateSanitizedExamplePartial() {
        const template = document.getElementById('examples_template') as HTMLTemplateElement;
        const templateContent = document.importNode(template.content, true)

        const cleanTemplateContent = DOMPurify.sanitize(templateContent, { RETURN_DOM_FRAGMENT: true });

        return cleanTemplateContent;
    }

    static generateExampleListItem() {
        const listItem = document.createElement('li');
        listItem.classList.add('examples-item', 'list-group-item', 'my-5');
        const liIdNum = window.crypto.getRandomValues(new Uint32Array(1))[0].toString();
        listItem.id = `example_item_${liIdNum}`;
        
        return listItem;
    }

    insertBlankExample() {
        const listItem: HTMLLIElement = ExampleFieldsManager.generateExampleListItem();
        const dirtyPartial = ExampleFieldsManager.generateSanitizedExamplePartial();
        listItem.appendChild(dirtyPartial);

        this.examples_list.appendChild(listItem);
        this._removeExampleListener(listItem);
    }

    _addExampleListener() {
        const addExampleBtn = document.getElementById('add_example_btn') as HTMLButtonElement;
        addExampleBtn.addEventListener('click', (event: MouseEvent) => {
            this.insertBlankExample();
        });
    }

    _removeExampleListener(exampleEl: HTMLLIElement) {
        exampleEl.addEventListener('click', (event: Event) => {
            const exampleEl = event.target as HTMLElement;
            if (exampleEl.id === 'remove_example_btn') {
                const delListItem = event.currentTarget as HTMLLIElement;
                delListItem.remove();
            }
        });
    }
}

export default ExampleFieldsManager;