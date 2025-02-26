<?php
require_once("header.php");
require_once("file_handler.php");

// Check if JSON data is received
if ($_SERVER["REQUEST_METHOD"] == "POST") {
	$jsonData = file_get_contents('php://input');
	if (!empty($jsonData) && $jsonData !== "") {
		// Decode the JSON data into an array of objects
		$payload = json_decode($jsonData, true);

		// Delete entry from data file
		if ($payload !== null) {
			try {
				$data = open_file_and_get_data();
				if (!$data || $data == "")
					throw new Exception("data is empty.");
				
                // Remove the string from the array
                $diffData = array_filter($data, function ($line) use ($payload) {
                    return trim($line) !== trim($payload);
                });

				write_array_to_file($diffData);
			} catch (Exception $e) {
				echo json_encode(["error" => $e->getMessage()]);
				http_response_code(500);
			}
		}
	}
}
