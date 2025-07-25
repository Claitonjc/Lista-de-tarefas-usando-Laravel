<?php

use App\Http\Controllers\ProfileController;
use App\Http\Controllers\TasksController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::middleware('auth')->group(function() {
    Route::resource('tasks', TasksController::class);
});

Route::patch('tasks/{task}/status', [TasksController::class, 'status'])->name('tasks.status');


Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

Route::get('/debug', function () {
    phpinfo(); // ou: return response()->json(['ok' => true]);
});


require __DIR__.'/auth.php';
