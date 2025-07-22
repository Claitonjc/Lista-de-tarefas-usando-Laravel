<?php

namespace App\Http\Controllers;

use App\Models\Task;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class TasksController extends Controller
{
    /**
     * Exibe a lista de tarefas.
     */
    public function index()
    {
        $tasks = Task::all()
        ->where('user_id', Auth::id());

        return view('tasks.index', compact('tasks'));
    }

    /**
     * Mostra a página de formulário para criar uma nova tarefa.
     */
    public function create()
    {
        return view('tasks.create');
    }

    /**
     * Armazena no banco de dados a tarefa criada.
     */
    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'title' => 'required|string|max:100',
            'description' => 'nullable|string',
        ]);

        $validatedData['status'] = 'pendente';
        $validatedData['user_id'] = Auth::id();

        Task::create($validatedData);

        return redirect()->route('tasks.index')->with('succes', 'Tarefa criada com sucesso!');
    }

    /**
     * Salva o status da tarefa
     */
    public function status(Task $task, Request $request)
    {
        $task->status = $request->has('status') ? 'concluída' : 'pendente';

        $task->save();

        return redirect()->route('tasks.index');
    }

    /**
     * Mostra o formulário para editar uma tarefa específica.
     */
    public function edit(Task $task)
    {
        return view('tasks.edit', compact('task'));
    }

    /**
     * Atualiza no banco de dados uma tarefa específica.
     */
    public function update(Request $request, Task $task)
    {
        if($task->user_id !== Auth::id()){
            abort(403, 'Você não tem permissão para editar esta tarefa.');
        }

        $validatedData = $request->validate([
            'title' => 'required|string|max:100',
            'description' => 'nullable|string',
        ]);

        $task->update($validatedData);

        return redirect()->route('tasks.index')->with('success', 'Tarefa atualizada com sucesso.');
    }

    public function destroyModal()
    {

    }

    /**
     * Remove do banco de dados uma tarefa específica.
     */
    public function destroy(Task $task)
    {
        if($task->user_id !== Auth::id()){
            abort(403, 'Você não tem permissão para excluir esta tarefa.');
        }

        $task->delete();

        return redirect()->route('tasks.index')->with('success', 'Tarefa excluída com sucesso.');
    }
}
