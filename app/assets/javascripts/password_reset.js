		$(document).ready(function()
		{
			/*
			 * JS login effect
			 * This script will enable effects for the login page
			 */
				// Elements
			var doc = $('html').addClass('js-login'),
				container = $('#container'),
				formReset = $('#form-reset'),

				// If layout is centered
				centered;

			/******* EDIT THIS SECTION *******/

			/*
			 * AJAX login
			 * This function will handle the login process through AJAX
			 */
			formReset.submit(function(event)
			{
				// Values
				var pass = $.trim($('#user_password').val()),
					pass_conf = $.trim($('#user_password_confirmation').val());

				// Check inputs
				if (pass.length === 0)
				{
					// Display message
					displayError('Please fill in your password');
					return false;
				}
				else if (pass_conf === 0)
				{
                                        formReset.clearMessages();
					displayError('Please fill in your password confirmation');
				}
				else if (pass != pass_conf)
				{
					// Remove empty reset message if displayed
					formReset.clearMessages('Please fill in your password');

					// Display message
					displayError('The password and password confirmation do not match, please try again.');
					return false;
				}
				else
				{
					// Remove previous messages
					formReset.clearMessages();

					// Show progress
					displayLoading('Updating your password...');
					event.preventDefault();

					// Stop normal behavior
					event.preventDefault();
				}
			});

			/******* END OF EDIT SECTION *******/

			// Handle resizing (mostly for debugging)
			function handleLoginResize()
			{
				// Detect mode
				centered = (container.css('position') === 'absolute');

				// Set min-height for mobile layout
				if (!centered)
				{
					container.css('margin-top', '');
				}
				else
				{
					if (parseInt(container.css('margin-top'), 10) === 0)
					{
						centerForm(false);
					}
				}
			};

			// Register and first call
			$(window).bind('normalized-resize', handleLoginResize);
			handleLoginResize();

			/*
			 * Center function
			 * @param boolean animate whether or not to animate the position change
			 * @param string|element|array any jQuery selector, DOM element or set of DOM elements which should be ignored
			 * @return void
			 */
			function centerForm(animate, ignore)
			{
				// If layout is centered
				if (centered)
				{
					var siblings = formReset.siblings(),
						finalSize = formReset.outerHeight();

					// Ignored elements
					if (ignore)
					{
						siblings = siblings.not(ignore);
					}

					// Get other elements height
					siblings.each(function(i)
					{
						finalSize += $(this).outerHeight(true);
					});

					// Setup
					container[animate ? 'animate' : 'css']({ marginTop: -Math.round(finalSize/2)+'px' });
				}
			};

			// Initial vertical adjust
			centerForm(false);

			/**
			 * Function to display error messages
			 * @param string message the error to display
			 */
			function displayError(message)
			{
				// Show message
				var message = formReset.message(message, {
					append: false,
					arrow: 'bottom',
					classes: ['red-gradient'],
					animate: false					// We'll do animation later, we need to know the message height first
				});

				// Vertical centering (where we need the message height)
				centerForm(true, 'fast');

				// Watch for closing and show with effect
				message.bind('endfade', function(event)
				{
					// This will be called once the message has faded away and is removed
					centerForm(true, message.get(0));

				}).hide().slideDown('fast');
			}

			/**
			 * Function to display loading messages
			 * @param string message the message to display
			 */
			function displayLoading(message)
			{
				// Show message
				var message = formReset.message('<strong>'+message+'</strong>', {
					append: false,
					arrow: 'bottom',
					classes: ['blue-gradient', 'align-center'],
					stripes: true,
					darkStripes: false,
					closable: false,
					animate: false					// We'll do animation later, we need to know the message height first
				});

				// Vertical centering (where we need the message height)
				centerForm(true, 'fast');

				// Watch for closing and show with effect
				message.bind('endfade', function(event)
				{
					// This will be called once the message has faded away and is removed
					centerForm(true, message.get(0));

				}).hide().slideDown('fast');
			}
		});
