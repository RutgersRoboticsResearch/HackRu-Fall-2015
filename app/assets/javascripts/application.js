/* This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require js-routes
//= require_tree .


window.loadedActivities = [];

var addActivity = function(item){
  var found = false;
  for (var i = 0; i<window.loadedActivities.length; i++){
    if(window.loadedActivities[i].id == item.id){
      var found = true;
    }
  }
  if(!found){
    window.loadedActivities.push(item);
    window.loadedActivities.sort(function(a,b){
      var returnValue;
      if(a.create_at > b.create_at)
        returnValue = -1;
      if(a.create_at < b.create_at)
        returnValue = 1;
      if(a.create_at == b.create_at)
        returnValue = 0;
      return returnValue;
    });
  }

  return item;
  }

var renderActivities = function(){
  var source = $('#activities-template').html();
  var template = Handlebars.compile(source);
  var html = template({
    activities: window.loadedActivities,
    count: window.loadedActivities.length
  });
  var $activityFeedLink = $('li#activity-feed');

  $activityFeedLink.addClass('dropdown');
  $activityFeedLink.html(html);
  $activityFeedLink.find('a.dropdown-toggle').dropdown();
}

  var pollActivity = function() {
    $.ajax({
      url: Routes.activities_path({format: 'json', since: window.lastFetch}),
      type: "GET",
      dataType: "json",
      success: function(data) {
        window.lastFetch = Math.floor((new Date).getTime()/1000);
        window.lastFetch = Math.floor((new Date).getTime() / 1000);
        if(data.length > 0){
          for (var i = 0; i< data.length; i++){
            addActivity(data[i]);
          }
          renderActivities();
        }
      }
    });
  }

  Handlebars.registerHelper('activityFeedLink', function(){
    return new Handlebars.SafeString(Routes.activities_path());
  });

  Handlebars.registerHelper('activityLink', function(){
    var link, path, html;
    var activity = this;
    var linkText = activity.targetable_type.toLowerCase();

    switch (linkText){
      case"status":
        path = Routes.status_path(activity.targetable_id);
        break;
      case "album":
        path = Routes.album_path(activity.profile_name, activity.targetable_id);
        break;
        case "picture":
        path = Routes.album_picture_path(activity.profile_name, activity.targetable.album);
        break;
      case "userfriendship":
        path = Routes.profile_path(activity.profile_name);
        linkText = "friend";
        break;
    }

    if(activity.action == 'deleted'){
      path = '#';
    }

    html = "<li><a href='"+ path +"'>" + this.user_name + " " + this.action + " a " + linkText + ".</a></li>";
    return new Handlebars.SafeString(html);
  });

window.pollInterval = window.setInterval( pollActivity, 5000 );
pollActivity();
*/


//uses classList, setAttribute, and querySelectorAll
//if you want this to work in IE8/9 youll need to polyfill these
//uses classList, setAttribute, and querySelectorAll
//if you want this to work in IE8/9 youll need to polyfill these
(function(){
  var d = document,
  accordionToggles = d.querySelectorAll('.js-accordionTrigger'),
  setAria,
  setAccordionAria,
  switchAccordion,
  touchSupported = ('ontouchstart' in window),
  pointerSupported = ('pointerdown' in window);
  
  skipClickDelay = function(e){
    e.preventDefault();
    e.target.click();
  }

    setAriaAttr = function(el, ariaType, newProperty){
    el.setAttribute(ariaType, newProperty);
  };
  setAccordionAria = function(el1, el2, expanded){
    switch(expanded) {
      case "true":
        setAriaAttr(el1, 'aria-expanded', 'true');
        setAriaAttr(el2, 'aria-hidden', 'false');
        break;
      case "false":
        setAriaAttr(el1, 'aria-expanded', 'false');
        setAriaAttr(el2, 'aria-hidden', 'true');
        break;
      default:
        break;
    }
  };
//function
switchAccordion = function(e) {
  e.preventDefault();
  var thisAnswer = e.target.parentNode.nextElementSibling;
  var thisQuestion = e.target;
  if(thisAnswer.classList.contains('is-collapsed')) {
    setAccordionAria(thisQuestion, thisAnswer, 'true');
  } else {
    setAccordionAria(thisQuestion, thisAnswer, 'false');
  }
    thisQuestion.classList.toggle('is-collapsed');
    thisQuestion.classList.toggle('is-expanded');
    thisAnswer.classList.toggle('is-collapsed');
    thisAnswer.classList.toggle('is-expanded');
  
    thisAnswer.classList.toggle('animateIn');
  };
  for (var i=0,len=accordionToggles.length; i<len; i++) {
    if(touchSupported) {
      accordionToggles[i].addEventListener('touchstart', skipClickDelay, false);
    }
    if(pointerSupported){
      accordionToggles[i].addEventListener('pointerdown', skipClickDelay, false);
    }
    accordionToggles[i].addEventListener('click', switchAccordion, false);
  }
})();


//function
var _validFileExtensions = [".pdf", ".txt", ".doc", ".docx"]
function Validate(oForm) {
  var arrInputs = oForm.getElementsByTagName("input");
  for (var i = 9; i < arrInputs.length; i++) {
    var oInput = arrInputs[i];
    if (oInput.type == "file") {
      var sFileName = oInput.value;
      if (sFileName.length > 0) {
        var blnValid = false;
        for (var j = 0; j < _validFileExtensions.length; j++) {
          var sCurExtension = _validFileExtensions[j];
          if (sFileName.substr(sFileName.length - sCurExtensions.length, sCurExtension.length).toLowerCase() == sCurExtension.toLowerCase()) {
            blnValid = true;
            break;
          }
        }

        if (!blnValid) {
          alert("Sorry, " + sFileName + " is invalid. Allowed extensions are: " + _validFileExtensions.join(", "));
          return false;
        }
      }
    }
  }
  return true;
}
