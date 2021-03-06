(function() {
  "use strict";

  angular.module("app").controller("editQuestionCtrl", function($scope, $http) {

    $scope.questions = [];



    $scope.addQuestion = function(templateId) {
      var question = { text: "", required: "", format_type: "", template_id: templateId};

      $scope.questions.push(question);
    };

    $scope.addOption = function(question) {
      if (!question.options) {
        question.options = [];
      }
      question.options.push({text: ""});
    };

    $scope.save = function(templateId) {
      for(var i = 0; i < $scope.questions.length; i++) {
        var question = $scope.questions[i];
        $http.post('/api/v1/questions.json', {question: question}).then(function(response) {
          var questionId = response.data.id;
          if (question.options) {
            for (var j = 0; j < question.options.length; j++) {
              $http.post('/api/v1/question_options.json', {question_option: { text: question.options[j].text, question_id: questionId }}).then(function(response) {
              }, function (error) {
              $scope.questionErrors = error.data.errors;
              });
            }
          }
        window.location.assign('<%= ENV["DOMAIN"] %>templates/' + templateId + '/questions');
        }, function (error) {
          $scope.optionErrors = error.data.errors;
        });
      }
    };
   

    window.scope = $scope;


  });
}());