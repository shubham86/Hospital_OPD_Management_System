
(function($) {
  'use strict' ;
	
	
//loading
		 
	// Wait for window load
	$(window).load(function() {
		// Animate loader off screen
		$(".se-pre-con").fadeOut("slow");
	});

// Slider
		var revapi348,
				tpj=jQuery;

		tpj(document).ready(function() {
			if(tpj("#rev_slider_348_1").revolution == undefined){
				revslider_showDoubleJqueryError("#rev_slider_348_1");
			}else{
				revapi348 = tpj("#rev_slider_348_1").show().revolution({
					sliderType:"standard",
					jsFileLocation:"//server.local/revslider/wp-content/plugins/revslider/public/assets/js/",
					sliderLayout:"fullscreen",
					dottedOverlay:"none",
					delay:12000,
								particles: {startSlide: "first", endSlide: "last", zIndex: "1",
									particles: {
										number: {value: 100}, color: {value: "#ffffff"},
										shape: {
											type: "circle", stroke: {width: 0, color: "#ffffff", opacity: 1},
											image: {src: ""}
										},
										opacity: {value: 0.75, random: true, min: 0.25, anim: {enable: false, speed: 3, opacity_min: 0, sync: false}},
										size: {value: 2, random: true, min: 0.5, anim: {enable: false, speed: 40, size_min: 1, sync: false}},
										line_linked: {enable: false, distance: 150, color: "#ffffff", opacity: 0.4, width: 1},
										move: {enable: true, speed: 1, direction: "top", random: true, min_speed: 3, straight: false, out_mode: "out"}},
									interactivity: {
										events: {onhover: {enable: false, mode: "repulse"}, onclick: {enable: false, mode: "repulse"}},
										modes: {grab: {distance: 400, line_linked: {opacity: 0.5}}, bubble: {distance: 400, size: 40, opacity: 0.4}, repulse: {distance: 200}}
									}
								},
					navigation: {
						keyboardNavigation:"off",
						keyboard_direction: "horizontal",
						mouseScrollNavigation:"off",
									mouseScrollReverse:"default",
						onHoverStop:"off",
						arrows: {
							style:"uranus",
							enable:true,
							hide_onmobile:false,
							hide_onleave:false,
							tmp:'',
							left: {
								h_align:"right",
								v_align:"bottom",
								h_offset:60,
								v_offset:10
							},
							right: {
								h_align:"right",
								v_align:"bottom",
								h_offset:10,
								v_offset:10
							}
						}
					},
					responsiveLevels:[1240,1024,778,480],
					visibilityLevels:[1240,1024,778,480],
					gridwidth:[1240,1024,778,480],
					gridheight:[868,768,960,720],
					lazyType:"smart",
					parallax: {
						type:"scroll",
						origo:"slidercenter",
						speed:400,
						speedbg:1500,
						speedls:1000,
						levels:[5,10,15,20,25,30,35,40,60,46,-10,-15,-20,-25,-30,55],
					},
					shadow:0,
					spinner:"off",
					stopLoop:"off",
					stopAfterLoops:-1,
					stopAtSlide:-1,
					shuffle:"off",
					autoHeight:"off",
					fullScreenAutoWidth:"off",
					fullScreenAlignForce:"off",
					fullScreenOffsetContainer: "",
					fullScreenOffset: "",
					hideThumbsOnMobile:"off",
					hideSliderAtLimit:0,
					hideCaptionAtLimit:0,
					hideAllCaptionAtLilmit:0,
					debugMode:false,
					fallbacks: {
						simplifyAll:"off",
						nextSlideOnWindowFocus:"off",
						disableFocusListener:false,
					}
				});
			}

						RsParticlesAddOn(revapi348);
		try{initSocialSharing("348")} catch(e){}
		});	/*ready*/
	
// Counter
	$('.count').each(function () {
		$(this).prop('Counter',0).animate({
			Counter: $(this).text()
		}, {
			duration: 4000,
			easing: 'swing',
			step: function (now) {
				$(this).text(Math.ceil(now));
			}
		});
	});

	
 })(jQuery);// End of use strict



	
	function setREVStartSize(e){
		try{ var i=jQuery(window).width(),t=9999,r=0,n=0,l=0,f=0,s=0,h=0;					
			if(e.responsiveLevels&&(jQuery.each(e.responsiveLevels,function(e,f){f>i&&(t=r=f,l=e),i>f&&f>r&&(r=f,n=e)}),t>r&&(l=n)),f=e.gridheight[l]||e.gridheight[0]||e.gridheight,s=e.gridwidth[l]||e.gridwidth[0]||e.gridwidth,h=i/s,h=h>1?1:h,f=Math.round(h*f),"fullscreen"==e.sliderLayout){var u=(e.c.width(),jQuery(window).height());if(void 0!=e.fullScreenOffsetContainer){var c=e.fullScreenOffsetContainer.split(",");if (c) jQuery.each(c,function(e,i){u=jQuery(i).length>0?u-jQuery(i).outerHeight(!0):u}),e.fullScreenOffset.split("%").length>1&&void 0!=e.fullScreenOffset&&e.fullScreenOffset.length>0?u-=jQuery(window).height()*parseInt(e.fullScreenOffset,0)/100:void 0!=e.fullScreenOffset&&e.fullScreenOffset.length>0&&(u-=parseInt(e.fullScreenOffset,0))}f=u}else void 0!=e.minHeight&&f<e.minHeight&&(f=e.minHeight);e.c.closest(".rev_slider_wrapper").css({height:f})					
		}catch(d){console.log("Failure at Presize of Slider:"+d)}
	};
