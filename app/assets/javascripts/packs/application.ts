import '../codelet_form';
import '../codelet_show';
import ExampleFieldsManager from '../example_fields_manager';

import 'css/stylesheets/application';

// bootstrap flash alert button close
import 'bootstrap/js/src/alert';

declare global {
    interface Window { Librarian: any; }
}

// set up Librarian namespace
window.Librarian = {};


document.addEventListener('DOMContentLoaded', (_event: Event) => {
    window.Librarian.ExampleFieldsManager = new ExampleFieldsManager();
})