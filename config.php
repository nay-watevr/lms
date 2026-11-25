<?php
// Konfigurasi database untuk XAMPP lokal maupun hosting.
date_default_timezone_set('Asia/Jakarta');

ini_set('session.use_strict_mode', '1');

if (session_status() === PHP_SESSION_NONE) {
    session_set_cookie_params([
        'httponly' => true,
        'samesite' => 'Lax',
        'secure' => !empty($_SERVER['HTTPS'])
            && $_SERVER['HTTPS'] !== 'off',
        'path' => '/',
    ]);

    session_start();
}

// Utamakan environment variable pada hosting.
// Jika tidak tersedia, gunakan nilai fallback di bawah dan sesuaikan.
$dbHost = getenv('LMS_DB_HOST') ?: '127.0.0.1';
$dbName = getenv('LMS_DB_NAME') ?: 'lms_ptik';
$dbUser = getenv('LMS_DB_USER') ?: 'root';
$dbPass = getenv('LMS_DB_PASS');

if ($dbPass === false) {
    $dbPass = '';
}

try {
    $pdo = new PDO(
        "mysql:host={$dbHost};dbname={$dbName};charset=utf8mb4",
        $dbUser,
        $dbPass,
        [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
        ]
    );
} catch (PDOException $exception) {
    error_log($exception->getMessage());

    http_response_code(500);

    exit(
        'Koneksi database gagal. Periksa host, nama database, '
        . 'username, dan password database pada config.php.'
    );
}

if (empty($_SESSION['csrf'])) {
    $_SESSION['csrf'] = bin2hex(random_bytes(32));
}

// Mengamankan teks sebelum ditampilkan pada halaman.
function e($teks)
{
    return htmlspecialchars(
        (string) $teks,
        ENT_QUOTES | ENT_SUBSTITUTE,
        'UTF-8'
    );
}

// Memeriksa token formulir.
function cekToken()
{
    $token = $_POST['csrf'] ?? '';

    if (
        !is_string($token)
        || !isset($_SESSION['csrf'])
        || !hash_equals($_SESSION['csrf'], $token)
    ) {
        http_response_code(403);

        exit(
            'Sesi formulir tidak valid. Muat ulang halaman, '
            . 'kemudian coba kembali.'
        );
    }
}
