<?php
require_once("assets/utility/input_check.php");
require_once("file_handler.php");
?>

<main id="msg_form" action="" method="post">
    <?php
    if (isset($_POST['message'])) {
        /**
         * Extract and save content to data file
         */
        $content = ft_validate_input($_POST['message']);
        $datetime = date('Y-m-d H:i:s');

        if ($content && trim($content) != "") {
            try {
                $entry = $datetime . ',' . $content;

                // Get the old entries
                $data = open_file_and_get_data();

                // Add the new entry to the top of the file as we want the
                // new entries to be displayed first.
                array_unshift($data, $entry);

                // Create a new file with the same name containing the new data
                write_array_to_file($data);
                // Redirect to avoid resubmission after refresh
                header('Location: ' . $_SERVER['REQUEST_URI']);
                exit;
            } catch (Exception $e) {
                echo json_encode(["error" => $e->getMessage()]);
                http_response_code(500);
            }
        }
    }
    ?>

    <FIELDSET>
        <!--------------- INTRO --------------->
        <p id="website-intro">
            Make your slate notes available from anywhere.
        </p>

        <!--------------- NOTE WRITING FORM --------------->
        <form action="" method="post">
            <label for="message" class="section-title">
                <span class="red">*</span>add content<span class="red">*</span>
            </label>
            <textarea
                id="message"
                name="message"
                maxlength="<?php echo MSG_MAX_LEN; ?>"></textarea>

            <!--------------- NOTE CHAR COUNTER --------------->
            <div id="char_count">
                <span id="current">0</span>
                <span id="max">/ 5000</span>
            </div>

            <!--------------- NOTE SUBMIT BUTTON --------------->
            <button type="submit" name="submit" value="SUBMIT" class="submit">
                ADD
            </button>
        </form>
    </FIELDSET>

    <?php require_once('slate_notes.php'); ?>
</main>

<script src="assets/js/char_counter.js?v=1.0.1"></script>