/** ajax page update for packages */


var PackageFilter = new Class({
/********************************************
  This function is for updating div content.
 *******************************************/

	initialize: function() {
	    $('search-button').addEvent('click', function(ev) {
		    var ev = new Event(ev);
		    ev.preventDefault();
		    this.updateContent($('packages-list'),
				       'http://193.219.145.203:3000/packages/_search/'+$('package').value
				       );
		}.bind(this));
	},

updateContent: function(container, url) {
    container.setHTML('<p>Loading&hellip;</p>');
    //container.set({html: '<p>Loading&hellip;</p>'});
    
    new Ajax(url, {
	    method: 'get',
		update: container,
		onComplete: function(container) {
		//container.toggleClass('where-are-col-active');
		//container.toggleClass('where-are-col');
		//this.bindEvents(container);
	    }.pass(container, this)
		  }).request();
    
	}    
    });


/********************************************
  Loading events for search filter
 *******************************************/



window.addEvent('domready', function() {
	if ($('search-content')) {
	 window.FILTERS_MANAGER=new PackageFilter();
	}
    });