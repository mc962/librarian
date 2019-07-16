import '../shared';
import ExampleFieldsManager from '../example_fields_manager';

import 'stylesheets/edit_codelet';

document.addEventListener('DOMContentLoaded', (_event: Event) => {
    window.Librarian.ExampleFieldsManager = new ExampleFieldsManager({pageType: 'edit'});
})