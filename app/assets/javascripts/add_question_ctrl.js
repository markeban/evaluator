(function() {
  "use strict";

  angular.module("app").controller("addQuestionCtrl", function($scope) {

    $scope.addQuestion = function() {
      return '<div class="panel panel-default">
        <div class="panel-heading">
          <h3 class="panel-title">Add Question</h3>
        </div>
        <div class="panel-body">
          <%= bootstrap_form_for [@template, @question] do |f| %> 
             <div>
               <%= f.text_field :text %>
              </div>
             <div>        <%= f.select :format_type, [["text", "text"], ["multiple choice", "multiple_choice"], ["true or false (yes or no)", "multiple_choice"], ["ranking", "ranking"]] %>      </div> 
              <div>
               <%= f.check_box :required %>
               </div>
             <div>
               <%= f.hidden_field :template_id, value: @template.id %>
             </div>
          <% end %>
       </div>
      </div>'
    };

   

    window.scope = $scope;


  });
}());