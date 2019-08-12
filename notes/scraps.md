 <!-- this will be done in a separate tab -->
 <div class='row d-flex'>
        <div class='col-lg-3'></div>
        <label for='examples_list' class='col-3 form-codelet-label font-weight-bold'>Examples</label>
        <button type='button' id='add_example_btn' class='btn btn-secondary btn-sm mx-auto p-lg-3'>Add Another Example</button>
        <div class='col-lg-3'></div>
    </div>
    <ul id='examples_list' class='list-group-flush'>
        <% codelet_examples.each do |example| %>
            <%= render partial: 'codelets/shared/example', locals: { codelet_form: codelet_form, codelet_examples: codelet_examples } %>
        <% end%>

        <%= render partial: 'codelets/shared/example_template', locals: { codelet_form: codelet_form, codelet_examples: [] } %>
    </ul>