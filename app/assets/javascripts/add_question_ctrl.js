(function() {
  "use strict";

  angular.module("app").controller("addQuestionCtrl", function($scope) {

    $scope.questions = [];

    $scope.addQuestion = function() {
      var question = { text: "", required: "", format_type: "", template_id: templateId }
      $scope.questions.push(question);
    };

    $scope.save = function() {
      for(var i = 0; i < $scope.questions.length; i++) {

      };
    };

   

    window.scope = $scope;


  });
}());