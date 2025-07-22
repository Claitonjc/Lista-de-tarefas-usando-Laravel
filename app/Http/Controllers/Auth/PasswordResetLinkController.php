<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Password;
use Illuminate\View\View;

class PasswordResetLinkController extends Controller
{
    /**
     * Exibe a visualização do pedido de link para redefinição de senha.
     */
    public function create(): View
    {
        return view('auth.forgot-password');
    }

    /**
     * Lida com um pedido de link para redefinir a senha recebido.
     *
     * @throws \Illuminate\Validation\ValidationException
     */
    public function store(Request $request): RedirectResponse
    {
        $request->validate([
            'email' => ['required', 'email'],
        ]);

        // Enviaremos o link de redefinição de senha para este usuário. Assim que tentarmos
        // enviar o link, examinaremos a resposta e então veremos a mensagem que precisamos
        // mostrar ao usuário. Por fim, enviaremos uma resposta adequada.
        $status = Password::sendResetLink(
            $request->only('email')
        );

        return $status == Password::RESET_LINK_SENT
                    ? back()->with('status', __($status))
                    : back()->withInput($request->only('email'))
                        ->withErrors(['email' => __($status)]);
    }
}
