<?php

require_once("header.php");

function open_file_and_get_data($filePath = DATA)
{
	// Check if the file exists
	if (file_exists($filePath)) {	
		// Open the file for reading
		$file = fopen($filePath, 'r');

		// Check if the file was opened successfully
		if ($file) {
			$data = [];
			
			// Read the file line by line.
			while (($line = fgets($file)) !== false)
				array_push($data, trim($line));

			fclose($file);

			return $data;
		} else {
			throw new Exception("Error: Unable to open the file.");
		}
	} else {
		throw new Exception("Error: File does not exist.");
	}
}

function write_array_to_file($array, $file = DATA)
{
	// Convert array to string with each value on a new line
	$dataToWrite = implode("\n", $array);
	// Create a new file with the same name containing the new data
	file_put_contents(DATA, $dataToWrite);
}