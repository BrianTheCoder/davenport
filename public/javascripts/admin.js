$(document).ready(function(){
  $.tablesorter.defaults.widgets = ['zebra'];
  $('table#posts').tablesorter();
  $('textarea#post_body').markItUp(mySettings);
});

mySettings = {	
	onShiftEnter:  	{keepDefault:false, replaceWith:'<br />\n'},
	onCtrlEnter:  	{keepDefault:false, openWith:'\n<p>', closeWith:'</p>'},
	onTab:    		{keepDefault:false, replaceWith:'    '},
	markupSet:  [ 	
		{name:'Bold', key:'B', openWith:'(!(<strong>|!|<b>)!)', closeWith:'(!(</strong>|!|</b>)!)' },
		{name:'Italic', key:'I', openWith:'(!(<em>|!|<i>)!)', closeWith:'(!(</em>|!|</i>)!)'  },
		{name:'Stroke through', key:'S', openWith:'<del>', closeWith:'</del>' },
		{separator:'---------------' },
		{name:'Picture', key:'P', replaceWith:'<img src="[![Source:!:http://]!]" alt="[![Alternative text]!]" />' },
		{name:'Link', key:'L', openWith:'<a href="[![Link:!:http://]!]"(!( title="[![Title]!]")!)>', closeWith:'</a>', placeHolder:'Your text to link...' },
		{separator:'---------------' },
		{name:'Clean', className:'clean', replaceWith:function(markitup) { return markitup.selection.replace(/<(.*?)>/g, "") } },		
		{name:'Preview', className:'preview',  call:'preview'}
	]
}

// $('.leader').each( function () {
//  var name = $(this).attr('name');
//  if ($(this).val()!='other') {
//    $(this).next().removeAttr('name').hide();
//  }
// });
// 
// 
// $('.leader').change(onChange);
// function onChange(){
//  var desiredName = $(this).attr('name');
//  if ($('#'+desiredName).val()=='other') {
//    $('#'+desiredName).next().attr('name',desiredName).fadeIn('fast');
//  }else {
//    $('#'+desiredName).next().removeAttr('name').fadeOut('fast');
//  }
// }