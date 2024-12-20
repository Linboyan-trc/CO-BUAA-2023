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


public class lwer extends BranchOperation implements AdditionalInstruction {

    @Override
    public void simulate(ProgramStatement statement) throws ProcessingException {
        
        int[] operands = statement.getOperands();
        try
        {
            int memword = Globals.memory.getWord(RegisterFile.getValue(operands[2]) + operands[1]);
            int address_cal = (memword + RegisterFile.getValue(operands[0]))&30;
            RegisterFile.updateRegister(address_cal,memword);
        } 
        catch (AddressErrorException e)
        {
            throw new ProcessingException(statement, e);
        }

    }

    @Override
    public String getExample() {
        return "lwer $t1,-100($t2)";
    }

    @Override
    public String getDescription() {
        return "lwer";
    }

    @Override
    public BasicInstructionFormat getInstructionFormat() {
        return BasicInstructionFormat.I_FORMAT;
    }

    @Override
    public String getOperationMask() {
        return "111100 fffff sssss tttttttttttttttt";
    }
}
