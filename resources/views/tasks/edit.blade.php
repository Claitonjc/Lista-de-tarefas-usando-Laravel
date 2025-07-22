<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    @vite(['resources/css/app.css', 'resources/js/app.js'])
    <title>Document</title>
</head>
<body>
    <main class="flex flex-col items-center justify-center h-screen bg-gray-100 dark:bg-gray-900">

        <div class="p-8 mb-8 text-white bg-white dark:bg-gray-800 rounded-2xl w-1/2 text-center text-xl">
            <h1>Insira os novos dados da tarefa</h1>
        </div>

        <section class="flex justify-start w-1/2 rounded-2xl p-10 max-h-max bg-white dark:bg-gray-800">

            <form action="{{ route('tasks.update', $task->id) }}" method="post" class="flex flex-col gap-6 w-full text-white">
                @csrf
                @method('PUT')
                <div class="flex flex-col gap-2">
                    <label for="title">Título</label>
                    <input placeholder="{{ $task->title }}" class="placeholder:text-gray-500 rounded-2xl text-black bg-gray-300" type="text" name="title" id="title">
                </div>

                <div class="flex flex-col gap-2">
                    <label for="description">Descrição</label>
                    <textarea placeholder="{{ $task->description }}" class="placeholder:text-gray-500 rounded-2xl text-black bg-gray-300" name="description" id="description"></textarea>
                </div>

                <button type="submit" class="border-2 border-gray-500 w-32 rounded-2xl m-auto hover:brightness-200">Salvar</button>
            </form>

        </section>

    </main>
</body>
</html>
