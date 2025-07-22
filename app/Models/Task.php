<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Task extends Model
{
    protected $fillable = ['title', 'description', 'status', 'user_id',];

    protected $primaryKey = 'id';

    protected function user()
    {
        return $this->belongsTo(User::class);
    }
}
