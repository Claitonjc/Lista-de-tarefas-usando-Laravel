<x-app-layout>
    <x-slot name="header">
        <div class="flex justify-around">
            <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
                {{ __('Tarefas') }}
            </h2>
            <a class="text-white hover:text-gray-500 underline underline-offset-4"
                href="{{ route('tasks.create') }}">Adicionar tarefa</a>
        </div>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                @forelse($tasks as $task)
                    <div class="p-6 text-gray-900 dark:text-gray-100 flex justify-between">
                        <div class="flex flex-col gap-3">
                            <h1 class="text-xl">{{ $task->title }}</h1>
                            <p class="text-xs">{{ $task->description }}</p>
                        </div>
                        <div class="flex flex-row gap-4 items-center">
                            <form action="{{ route('tasks.status', $task->id) }}" method="post">
                                @csrf
                                @method('PATCH')
                                <label for="status">Status: </label>
                                <input type="checkbox" class="accent-white appearance-auto" name="status" id="status"
                                    {{ $task->status === 'concluída' ? 'checked' : '' }} onchange="this.form.submit()">
                            </form>
                            <a class="hover:bg-gray-500 bg-white p-1 rounded text-black" href="{{ route('tasks.edit', $task) }}">Editar</a>
                            <div x-data="{ open: false }">
                                <button @click="open = true" class="bg-red-600 text-white p-1 rounded hover:bg-red-800">
                                    Deletar
                                </button>

                                <!-- Modal -->
                                <div x-show="open"
                                    class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50 z-50">
                                    <div class="bg-white p-6 rounded shadow-lg w-96">
                                        <h2 class="text-lg font-semibold mb-4 text-black">Tem certeza?</h2>
                                        <p class="mb-6 text-black">Essa ação não pode ser desfeita.</p>
                                        <div class="flex justify-end gap-4">
                                            <button @click="open = false" class="px-4 py-2 bg-gray-300 rounded text-black">
                                                Cancelar
                                            </button>
                                            <form method="POST" action="{{ route('tasks.destroy', $task->id) }}">
                                                @csrf
                                                @method('DELETE')
                                                <button type="submit" class="px-4 py-2 bg-red-600 text-white rounded">
                                                    Confirmar
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <hr class="opacity-25 w-[96%] m-auto mb-1">
                @empty
                    <p class="text-white p-2">Você não possui tarefas cadastradas.</p>
                @endforelse
            </div>
        </div>
    </div>
</x-app-layout>
