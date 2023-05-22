<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateEquipmentTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('equipment', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('serial_no');
            $table->string('model');
            $table->unsignedBigInteger('department_id');
            $table->unsignedBigInteger('sub_category_id');
            $table->unsignedBigInteger('supplier_engineer_id');
            $table->dateTime('installation_date');
            $table->dateTime('warrenty')->nullable();
            $table->boolean('status')->default(true);
            $table->timestamps();

            $table->unique(['name', 'serial_no']);
            $table->foreign('department_id')->references('id')->on('departments');
            $table->foreign('sub_category_id')->references('id')->on('sub_categories')->onDelete('cascade');
            $table->foreign('supplier_engineer_id')->references('id')->on('supplier_engineers');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('equipment');
    }
}
