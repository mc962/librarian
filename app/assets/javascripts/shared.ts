// bootstrap flash alert button close
import 'bootstrap/js/src/alert';

declare global {
    interface Window { Librarian: any; }
}

// set up Librarian namespace
window.Librarian = {};