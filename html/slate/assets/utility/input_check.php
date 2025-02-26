<?php
// Functions that validate form data by removing/replacing
// unwanted characters for security

function ft_validate_input_trim($data)
{
    $data = trim($data);
    $safeInput = htmlspecialchars(strip_tags($data), ENT_QUOTES, 'UTF-8');
    return $safeInput;
}

// Here we do not trim to keep the original input
function ft_validate_input($data)
{
    $safeInput = htmlspecialchars(strip_tags($data), ENT_QUOTES, 'UTF-8');
    return $safeInput;
}

// Truncate string that is too long before saving it to the database
function ft_truncate_before_saving($text, $length)
{
    if ($length >= \strlen($text)) {
        return $text;
    }

  return preg_replace(
      "/^(.{1,$length})(\s.*|$)/s",
      '\\1...',
      $text
  );
}