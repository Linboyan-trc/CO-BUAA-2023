import mars.Globals;
import mars.ProcessingException;
import mars.ProgramStatement;
import mars.mips.hardware.AddressErrorException;
import mars.mips.hardware.RegisterFile;
import mars.mips.instructions.AdditionalInstruction;
import mars.mips.instructions.BasicInstruction;
import mars.mips.instructions.BasicInstructionFormat;
import mars.mips.instructions.BranchOperation;
import mars.mips.instructions.SimulationCode;


public class bezal extends BranchOperation implements AdditionalInstruction {

    @Override
    public void simulate(ProgramStatement statement) throws ProcessingException {
        
        int[] operands = statement.getOperands();
                  
        if (RegisterFile.getValue(operands[1]) == 0)
        {
            processJump(RegisterFile.getValue(operands[0]));
            processReturnAddress(31);
        }

    }

    @Override
    public String getExample() {
        return "bezal $t1,$t2";
    }

    @Override
    public String getDescription() {
        return "bezal";
    }

    @Override
    public BasicInstructionFormat getInstructionFormat() {
        return BasicInstructionFormat.R_FORMAT;
    }

    @Override
    public String getOperationMask() {
        return "000000 fffff sssss 00000 00000 111101";
    }
}
