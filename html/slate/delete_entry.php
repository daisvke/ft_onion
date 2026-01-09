<?php
require_once("header.php");
require_once("file_handler.php");

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $jsonData = file_get_contents("php://input");

    if ($jsonData === false || trim($jsonData) === "") {
        http_response_code(400);
        echo json_encode(["error" => "No input received"]);
        exit;
    }

    // Decode JSON STRING
    $entryToDelete = json_decode($jsonData, true);

    if (!is_string($entryToDelete)) {
        http_response_code(400);
        echo json_encode(["error" => "Invalid payload"]);
        exit;
    }

    try {
        $data = open_file_and_get_data();

        if (empty($data)) {
            throw new Exception("Data file is empty.");
        }

        $entryToDelete = trim($entryToDelete);

        $filteredData = array_values(array_filter($data, function ($line) use ($entryToDelete) {
            return trim($line) !== $entryToDelete;
        }));

        write_array_to_file($filteredData);

        echo json_encode(["success" => true]);
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(["error" => $e->getMessage()]);
    }
}
