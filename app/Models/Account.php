<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use \Staudenmeir\EloquentHasManyDeep\HasRelationships;

class Account extends Authenticatable
{
    use HasFactory, Notifiable, HasRelationships;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'email',
        'password',
        'employee_id',
        'status'
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password',
        'remember_token',
        'employee_id',
        'status',
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public function employee()
    {
        return $this->belongsTo(Employee::class);
    }

    public function department()
    {
        return $this->hasOneThrough(
            Department::class,
            Employee::class,
            'id',
            'id',
            'employee_id',
            'department_id'
        );
    }

    public function role()
    {
        return $this->hasOneThrough(
            Role::class,
            Employee::class,
            'id',
            'id',
            'employee_id',
            'role_id'
        );
    }

    public function permissions()
    {
        return $this->hasManyDeepFromRelations($this->role(), (new Role)->permissions());
    }

    public function abilities()
    {
        return $this->permissions()->pluck('slug');
    }

    public function panels()
    {
        return $this->hasManyDeepFromRelations($this->role(), (new Role)->panels());
    }
}
