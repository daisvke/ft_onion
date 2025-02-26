<?php
require_once("file_handler.php");

$message = null;
?>

<FIELDSET>
<p id="website-intro" class="section-title">Notes:</p>

<ul id="entries">

<?php
try {
	$data = open_file_and_get_data();

	foreach($data as $line) {
		// Trim whitespace from the line
		$trimmed_line = ft_validate_input_trim($line);
		if ($trimmed_line && $trimmed_line !== "") {
			// Find the position of the first comma
			$commaPosition = strpos($trimmed_line, ',');
			if ($commaPosition !== false) {
				// Split the string at the first comma
				$datetime = substr($trimmed_line, 0, $commaPosition);
				$note = substr($trimmed_line, $commaPosition + 1);
			}
			?>
			<div class="note-div">
				<div>
					<?php echo $datetime . "      " ?>
				</div>

				<div class="note-input-div">
					<input
						name="content"
						class="note-input"
						id="note-<?php echo $datetime; ?>"
						value="<?php echo $note ?>">
				</div>

				<div class="copy-del-buttons">
					<!--------------- COPY BUTTON --------------->
					<div>
						<button
							type="button"
							id="copy"
							class="green-button"
							onClick="copyText('note-<?php echo $datetime; ?>', 'copied-<?php echo $datetime; ?>')"
							>
							COPY
						</button>
						<!-- Notification after the user clicks on the button -->
						<div id="copied-<?php echo $datetime; ?>" class="hide">
							COPIED
						</div>
					</div>

					<!--------------- DEL BUTTON --------------->
					<div>
						<button
							type="button"
							style="background-color: #000;"
							onClick="delEntryOnDb(
								'<?php echo $trimmed_line; ?>'
							)">
							<img
								class="del-button"
								src="assets/img/trash.png"
								alt="DEL"
							>
						</button>
					</div>
				</div>
		</div><?php
		}
	}
	?>
</ul>
</FIELDSET>

<script src="assets/js/handle_entry.js"></script>

<?php
} catch (Exception $e) { ?>
<script>alert(<?php "Failed reading data: " . $e->getMessage(); ?>)</script>
<?php }