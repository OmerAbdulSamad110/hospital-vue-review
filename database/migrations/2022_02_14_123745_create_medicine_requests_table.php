<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMedicineRequestsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('medicine_requests', function (Blueprint $table) {
            $table->id();
            $table->foreignId('department_id')->constrained()->onDelete('cascade');
            $table->foreignId('approver_id')->nullable()->constrained('employees')
                ->onDelete('set null');
            $table->foreignId('requester_id')->constrained('employees')->onDelete('cascade');
            $table->foreignId('hod_id')->constrained('employees');
            $table->foreignId('hon_id')->constrained('employees');
            $table->foreignId('pharmacist_id')->constrained('employees');
            $table->foreignId('medicine_id')->constrained()->onDelete('cascade');
            $table->bigInteger('quantity');
            $table->boolean('type')->default(false);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('medicine_requests');
    }
}
