# ✅ Lista de Tarefas (To-Do List) – Laravel

Um gerenciador simples e funcional de tarefas desenvolvido com [Laravel 12](https://laravel.com/), usando SQLite como banco de dados. Ideal para estudo, demonstração de habilidades ou uso pessoal.

![Laravel](https://img.shields.io/badge/Laravel-12.x-red?style=flat-square&logo=laravel)
![PHP](https://img.shields.io/badge/PHP-8.2-blue?style=flat-square&logo=php)
![License](https://img.shields.io/badge/license-MIT-green?style=flat-square)

---

## 🚀 Funcionalidades

- ✅ Cadastro de tarefas
- ✏️ Edição de tarefas
- ❌ Exclusão de tarefas
- 📌 Marcar como concluída / pendente
- 🔒 Autenticação com Laravel Breeze
- 🌐 Interface simples

---

## 🛠️ Tecnologias Utilizadas

- **Laravel 12**
- **PHP 8.2**
- **SQLite** (como banco de dados local)
- **Laravel Breeze** (autenticação)
- **Tailwind CSS** (via Breeze)
- **Laravel Sanctum** (API-ready)
- **Composer** e **NPM**

---

## ⚙️ Instalação e Uso

### 📦 Pré-requisitos
- PHP 8.2+
- Composer
- Node.js e NPM
- SQLite

---

### 🧪 Clonar o projeto

- git clone https://github.com/seu-usuario/Lista-de-tarefas-usando-Laravel.git
- cd Lista-de-tarefas-usando-Laravel

### Instalar dependências

- composer install
- npm install

---

### ⚙️ Configurar ambiente

- cp .env.example .env
- php artisan key:generate
- touch database/database.sqlite
- php artisan migrate

---

### Verifique se .env contém:

- DB_CONNECTION=sqlite
- DB_DATABASE=${PWD}/database/database.sqlite

---

### ▶️ Rodar o projeto

- php artisan serve
- Acesse: http://localhost:8000

---

### 🧪 Rodar testes

- php artisan test

---

### 📁 Estrutura de diretórios

- app/ – Código da aplicação

- routes/web.php – Rotas da aplicação

- resources/views/ – Templates Blade

- database/ – Migrations, seeders e banco SQLite

- tests/ – Testes automatizados

---

### 📌 Observações

- O projeto usa SQLite por simplicidade. Pode ser facilmente adaptado para MySQL ou PostgreSQL.

- O deploy pode ser feito em serviços como Render ou Railway.

---

### 📄 Licença

- Este projeto está licenciado sob a MIT License.

---

### 🤝 Contribuição

- Pull requests são bem-vindos! Sinta-se à vontade para abrir issues e sugerir melhorias.

---

### 👨‍💻 Autor

- Desenvolvido por Claiton José Clemes
- GitHub: @Claitonjc
