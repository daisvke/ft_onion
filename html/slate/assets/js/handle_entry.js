//
// These functions handle note entries
//

// Copy note when the user clicks on the "click" button
function copyText(noteId, copiedMsgId) {
	const inputField = document.getElementById(noteId);

	// Check if the Clipboard API is available
	if (navigator.clipboard) {
		// Use the Clipboard API
		navigator.clipboard.writeText(inputField.value)
			.then(() => {
				// Display the 'COPIED' notification
				document.getElementById(copiedMsgId).classList.remove('hide');
				// console.log('Text copied to clipboard');
			})
			.catch(err => {
				console.error('Failed to copy: ', err);
			});
	} else {
		// Fallback for older browsers
		//
		// execCommand('copy') requires a selectable text element to work.
		// In most browsers, you cannot directly copy text without selecting it first.
		// By creating a temporary <textarea>, we can easily set its value to
		// the text we want to copy and then select that text.
		const tempTextArea = document.createElement('textarea');
		tempTextArea.value = inputField.value;
		document.body.appendChild(tempTextArea);
		tempTextArea.select();
		document.execCommand('copy');
		document.body.removeChild(tempTextArea);
		// Display the 'COPIED' notification
		document.getElementById(copiedMsgId).classList.remove('hide');
		// console.log('Text copied to clipboard (fallback)');
	}
}

function delEntryOnDb(entry) {
	if (confirm(`
		Are you sure you want to delete this entry below?\n`
		+ entry
		) == false) return;

	// Convert the note to a JSON string
	var jsonData = JSON.stringify(entry);

	try {
		const jsonString = JSON.stringify(entry);

		// Create a new XMLHttpRequest object
		var xhr = new XMLHttpRequest();

		// Configure the request
		xhr.open('POST', 'delete_entry.php', true);
		xhr.setRequestHeader('Content-Type', 'application/json');
		// Set up a callback function to handle the response
		xhr.onreadystatechange = function() {
			if (xhr.readyState === XMLHttpRequest.DONE) {
				if (xhr.status === 200) {
					location.reload();
				} else {
					// Request failed, handle the error
					console.error('Request failed with status:', xhr.status);
					return;
				}
			}
		};
		// Send the request
		xhr.send(jsonData);
	} catch (error) {
		console.error("Error:", error.message);
	}
}
