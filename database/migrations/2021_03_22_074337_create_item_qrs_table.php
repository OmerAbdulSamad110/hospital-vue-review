<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateItemQrsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('item_qrs', function (Blueprint $table) {
            $table->id();
            $table->dateTime('assigned_date')->nullable();
            $table->unsignedBigInteger('assignor_id')->nullable();
            $table->unsignedBigInteger('assignee_id')->nullable();
            $table->string('unique_value');
            $table->unsignedBigInteger('item_id');
            $table->unsignedBigInteger('department_id');
            $table->unsignedBigInteger('supplier_id');
            $table->date('purchased_at');
            $table->timestamps();

            $table->unique(['item_id', 'unique_value']);
            $table->foreign('item_id')->references('id')->on('items')->onDelete('cascade');
            $table->foreign('supplier_id')->references('id')->on('suppliers')->onDelete('cascade');
            $table->foreign('assignor_id')->references('id')->on('employees');
            $table->foreign('assignee_id')->references('id')->on('employees');
            $table->foreign('department_id')->references('id')->on('departments')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('item_qrs');
    }
}
