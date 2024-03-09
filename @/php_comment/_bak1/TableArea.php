<?php

namespace dev/excel;

use RuntimeException;

class TableArea
{

    private array $data;

    private int $xpos;

    private int $ypos;

    private int $column_count;

    private int $row_count;

    private array $table;

    public function __construct(
        array $data,
        int $xpos = 0,
        int $ypos = 0,
    ) {
        $this->data = $data;
        $this->xpos = $xpos;
        $this->ypos = $ypos;
        $this->row_count = 0;
        $this->column_count = 0;
    }

    public function rowData():array
    {
        return $this->data;
    }

    public function toArray():array
    {
        if (is_array($this->table)) {
            return $this->table;
        }





    }

    public function overwrite(
        TableArea $tableArea,
        int $xpos = 0,
        int $ypos = 0,
    ):TableArea {

    }

    private function calculate():void
    {
        foreach($this->data as $row_no => $row) {
            if (!is_array($row)) {
                throw new RuntimeException(
                    "must be array. row number:{$row_no}",
                );
            }
            
            $this->column_count = max(
                $this->column_count,
                count($row),
            );

            $this->row_count++;
        }
    }
}

