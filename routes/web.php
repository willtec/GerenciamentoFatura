<?php
// Este arquivo gerencia as rotas do sistema

// Configuração de logs
$logFile = __DIR__ . '/../logs/app.log'; // Ajuste o caminho conforme necessário

// Garantir que o diretório de logs existe
if (!is_dir(__DIR__ . '/../logs')) {
    mkdir(__DIR__ . '/../logs', 0755, true);
}

// Configurar o PHP para registrar os erros
ini_set('log_errors', 'On'); // Ativar o registro de erros
ini_set('error_log', $logFile); // Definir o arquivo de log
error_reporting(E_ALL); // Registrar todos os tipos de erros

// Teste inicial para confirmar que o log está funcionando
error_log("Início do script web.php. URI requisitada: " . ($_SERVER['REQUEST_URI'] ?? 'Indefinida'));

// Iniciar a sessão apenas se não estiver ativa
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

// Capturar a URI atual
$request = $_SERVER['REQUEST_URI'];
$request = strtok($request, '?'); // Ignorar parâmetros GET na URL

// Verificar se o prefixo "/LancamentoFatura" está presente
$basePath = '/LancamentoFatura';
if (strpos($request, $basePath) === 0) {
    $request = substr($request, strlen($basePath));
}

// Adicionar uma barra inicial para rotas padrão
$request = '/' . ltrim($request, '/');

// Função para verificar autenticação
function verificarAutenticacao()
{
    if (!isset($_SESSION['usuario'])) {
        header('Location: /login');
        exit();
    }
}

// Definir as rotas disponíveis no sistema
switch (true) {
    // Rota inicial ou dashboard
    case $request === '/' || $request === '/dashboard':
        verificarAutenticacao();
        include __DIR__ . '/../views/dashboard.php';
        break;

    // Rota para login
    case $request === '/login':
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            include __DIR__ . '/../controllers/LoginController.php';
        } else {
            include __DIR__ . '/../views/login.php';
        }
        break;

    // Rota para logout
    case $request === '/logout':
        verificarAutenticacao();
        include __DIR__ . '/../controllers/LogoutController.php';
        break;

    // Rota para usuarios
    case $request === '/usuarios':
        verificarAutenticacao();
        include __DIR__ . '/../controllers/UsuarioController.php';
        UsuarioController::index();
        break;

    case $request === '/usuarios/listar':
        verificarAutenticacao();
        include __DIR__ . '/../controllers/UsuarioController.php';
        UsuarioController::index();
        break;

    case $request === '/usuarios/cadastrar':
        verificarAutenticacao();
        include __DIR__ . '/../controllers/UsuarioController.php';
        UsuarioController::criar();
        break;

    case preg_match('#^/usuarios/editar/(\d+)$#', $request, $matches):
        verificarAutenticacao();
        include __DIR__ . '/../controllers/UsuarioController.php';
        UsuarioController::editar($matches[1]);
        break;

    case $request === '/usuarios/verificar':
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            include __DIR__ . '/../controllers/UsuarioController.php';
            UsuarioController::verificar();
        }
        break;

    case preg_match('#^/usuarios/excluir/(\d+)$#', $request, $matches):
        verificarAutenticacao();
        include __DIR__ . '/../controllers/UsuarioController.php';
        UsuarioController::excluir($matches[1]);
        break;

    // Rota para listar faturas
    case $request === '/faturas':
        verificarAutenticacao();
        include __DIR__ . '/../controllers/FaturaController.php';
        break;

    // Rota para cadastrar faturas
    case $request === '/faturas/cadastrar':
        verificarAutenticacao();
        include __DIR__ . '/../views/faturas/cadastrar.php';
        break;

    // Rota para listar transportadoras
    case $request === '/transportadoras':
        verificarAutenticacao();
        include __DIR__ . '/../controllers/TransportadoraController.php';
        break;

    // Rota para a API de transportadoras
    case preg_match('#^/api/transportadoras$#', $request):
        include __DIR__ . '/../routes/api.php';
        break;

    // Rota para cadastrar transportadoras
    case $request === '/transportadoras/cadastrar':
        verificarAutenticacao();
        include __DIR__ . '/../views/transportadoras/cadastrar.php';
        break;

    // Rota para editar transportadoras (GET com ID na URL)
    case preg_match('#^/transportadoras/editar/(\d+)$#', $request, $matches):
        verificarAutenticacao();
        $_GET['id'] = filter_var($matches[1], FILTER_SANITIZE_NUMBER_INT); // Capturar e sanitizar o ID da URL
        include __DIR__ . '/../controllers/TransportadoraController.php';
        break;

    // Processar edição (formulário enviado via POST)
    case $request === '/transportadoras/editar':
        verificarAutenticacao();
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            include __DIR__ . '/../controllers/TransportadoraController.php';
        } elseif ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['id'])) {
            $_GET['id'] = filter_var($_GET['id'], FILTER_SANITIZE_NUMBER_INT);
            include __DIR__ . '/../controllers/TransportadoraController.php';
        } else {
            http_response_code(405); // Método não permitido
            echo "Método não permitido";
        }
        break;

    // Rota para importar transportadoras via CSV
    case $request === '/transportadoras/import':
        verificarAutenticacao();
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            include __DIR__ . '/../controllers/TransportadoraController.php';
        } else {
            http_response_code(405); // Método não permitido
            echo "Método não permitido";
        }
        break;

    // Página para listar transportadoras
    case $request === '/transportadoras/listar':
        verificarAutenticacao();
        include __DIR__ . '/../views/transportadoras/listar.php';
        break;

    // Rota para exclusão de transportadoras
    case preg_match('#^/transportadoras/excluir/(\d+)$#', $request, $matches):
        verificarAutenticacao();
        $_GET['id'] = filter_var($matches[1], FILTER_SANITIZE_NUMBER_INT); // Capturar e sanitizar o ID
        include __DIR__ . '/../controllers/TransportadoraController.php';
        break;

    // Rota para ativar transportadoras
    case preg_match('#^/transportadoras/ativar/(\d+)$#', $request, $matches):
        verificarAutenticacao();
        $_GET['id'] = filter_var($matches[1], FILTER_SANITIZE_NUMBER_INT); // Capturar e sanitizar o ID
        include __DIR__ . '/../controllers/TransportadoraController.php';
        break;

    // Rota não encontrada
    default:
        http_response_code(404);
        echo "404 - Página $request não encontrada";
        break;
}
